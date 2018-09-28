package com.ikuyonn.project.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.protobuf.ByteString;
import com.ikuyonn.project.nameCard.mapper.NameCardMapper;
import com.ikuyonn.project.nameCard.vo.NameCard;
import com.ikuyonn.project.pagenavi.PageNavigator;
import com.ikuyonn.project.util.Auth;

@Controller
public class NameCardController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	SqlSession session;
	
	final int COUNTPERPAGE = 5;
	final int PAGEPERGROUP = 5;
	private String UPLOADPATH = "";
	
	//파일택스트변환 요청
	@RequestMapping(value = "/fileUplodeAction", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String fileUplodeAction(MultipartFile fileUplode,HttpServletRequest request) {
		//파일업로드
		String result = fileService(request,fileUplode);

		return result;
	}
	
	//이메일등록 검사
	@RequestMapping(value = "/selectNameCard", method = RequestMethod.POST)
	public @ResponseBody int selectNameCard(NameCard nameCard,HttpSession httpSession) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		nameCard.setUserID((String)httpSession.getAttribute("userID"));
		NameCard result = new NameCard();
		result = mapper.selectNameCard(nameCard);
		
		if(result == null) {
			return 0;
		}
		
		return 1;
	}	
	
	//명함등록요청
	@RequestMapping(value = "/nameCardUplodeAction", method = RequestMethod.POST)
	public @ResponseBody int nameCardUplodeAction(NameCard nameCard,HttpSession httpSession) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		nameCard.setUserID((String)httpSession.getAttribute("userID"));
		String hUserID = mapper.selectEmailAddress(nameCard); 
		if(hUserID == null) {
			//등록된사람 없을때
			nameCard.setEmailCheck("0");
		}else {
			//등록된사람 있을때
			nameCard.setEmailCheck("1");
			nameCard.sethUserID(hUserID);
		}
		int result = mapper.insertNameCard(nameCard);
		
		return result;
	}
	
	//명함리스트 출력/삭제
	@RequestMapping(value = "/selectNameCardList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> selectNameCardList(HttpSession httpSession, @RequestParam(value="page", defaultValue="1") int page, 
			@RequestParam(value="searchText", defaultValue="") String searchText,String type,NameCard nameCard, String[] emails) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		nameCard.setUserID((String)httpSession.getAttribute("userID"));
		//하나삭제
		if(nameCard.getNcEmail() != null) {
			mapper.deleteNameCard(nameCard);
		}
		//일괄살제
		if(emails != null) {
			for(String e : emails) {
				nameCard.setNcEmail(e);
				mapper.deleteNameCard(nameCard);
			}
		}	
		Map<String, String> search = new HashMap<>();
		search.put("searchText", searchText);
		search.put("type", type);
		search.put("emailCheck", nameCard.getEmailCheck());
		search.put("userID", nameCard.getUserID());
		int total = mapper.getTotal(search);
		PageNavigator pageNavigator = new PageNavigator(COUNTPERPAGE, PAGEPERGROUP, page, total);
		RowBounds rowBounds = new RowBounds(pageNavigator.getStartRecord(),pageNavigator.getCountPerPage());
		ArrayList<NameCard> nameCardList = mapper.selectNameCardList(rowBounds, search);
		Map<String, Object> result = new HashMap<>();
		result.put("nameCardList", nameCardList);
		result.put("pageNavigator", pageNavigator);
		result.put("searchText", searchText);
		System.out.println("nameCardList.size : "+nameCardList.size()+" searchText : "+searchText);
		return result;
	}
	
	@RequestMapping(value = "/getAllNC", method = RequestMethod.POST)
	public @ResponseBody ArrayList<NameCard> getAllNC(HttpSession ss) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		ArrayList<NameCard> result = mapper.getAllNC((String)ss.getAttribute("userID"));
		return result;
	}
	
	@RequestMapping(value = "/getMember", method = RequestMethod.POST)
	public @ResponseBody ArrayList<NameCard> getMember(HttpSession ss,String emailCheck) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		NameCard nc = new NameCard();
		nc.setUserID((String)ss.getAttribute("userID"));
		nc.setEmailCheck(emailCheck);
		ArrayList<NameCard> result = mapper.getMember(nc);
		return result;
	}
	//명함수정페이지	
	@RequestMapping(value = "/updateNameCard", method = RequestMethod.GET)
	public String updateNameCard(Model model,NameCard nameCard,HttpSession httpSession) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		nameCard.setUserID((String)httpSession.getAttribute("userID"));
		NameCard result = mapper.selectNameCard(nameCard);
		model.addAttribute("nameCard", result);
		return "nameCard/insertNameCard2";
	}
	
	//명함수정	
	@RequestMapping(value = "/updateNameCardAction", method = RequestMethod.POST)
	public @ResponseBody int updateNameCardAction(NameCard nameCard,HttpSession httpSession) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		nameCard.setUserID((String)httpSession.getAttribute("userID"));
		int result = mapper.upDateNameCard(nameCard);
		return result;
	}
	/************************ 파일업로드 / 사진텍스트 인식 ************************/
	
	//파일업로드
	public String fileService(HttpServletRequest request,MultipartFile uploadFile) {
		ServletContext cotx= request.getSession().getServletContext();
		String path = cotx.getRealPath("/resources/images/nameCard/");
		UPLOADPATH = path;
		File f = new File(UPLOADPATH);
		if(f.isDirectory() == false) {
			f.mkdirs();
		}
		System.out.println(path);
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid+"_"+uploadFile.getOriginalFilename();
		
		File saveFile = new File(UPLOADPATH,saveFileName);
		try {
			uploadFile.transferTo(saveFile);
			String result = vision(saveFileName);
			saveFile.delete();
			return result;
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		}
	}
	
	//사진텍스트 인식
	public String vision(String saveFileName) {
		try {
			
			String imageFilePath = UPLOADPATH + saveFileName;
			System.out.println(imageFilePath);
			List<AnnotateImageRequest> requests = new ArrayList<>();
		
			ByteString imgBytes = ByteString.readFrom(new FileInputStream(imageFilePath));
		
			Image img = Image.newBuilder().setContent(imgBytes).build();
			Feature feat = Feature.newBuilder().setType(Type.TEXT_DETECTION).build();
			AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
			requests.add(request);
		
			try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
				BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			    List<AnnotateImageResponse> responses = response.getResponsesList();
		
			    for (AnnotateImageResponse res : responses) {
			    	if (res.hasError()) {
			    		System.out.printf("Error: %s\n", res.getError().getMessage());
			    		return "";
			    	}
		
			    	System.out.println("Text : ");
			    	String data = res.getTextAnnotationsList().get(0).getDescription();
			    	System.out.println(data);
			    	
			    	return data;
			    }
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
}
