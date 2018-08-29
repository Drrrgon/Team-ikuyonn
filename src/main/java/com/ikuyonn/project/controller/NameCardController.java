package com.ikuyonn.project.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

@Controller
public class NameCardController {
	
	@Autowired
	SqlSession session;
	
	private static final String UPLOADPATH = "c:\\\\testFileinfo\\\\";
	
	//파일택스트변환 요청
	@RequestMapping(value = "/fileUplodeAction", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String fileUplodeAction(Model model, MultipartFile fileUplode) {
		//파일업로드
		String result = fileService(fileUplode);

		return result;
	}
	
	//명함등록요청
	@RequestMapping(value = "/nameCardUplodeAction", method = RequestMethod.POST)
	public @ResponseBody int nameCardUplodeAction(NameCard nameCard,HttpSession httpSession) {
		NameCardMapper mapper = session.getMapper(NameCardMapper.class);
		nameCard.setUserID((String)httpSession.getAttribute("userID"));
		System.out.println(nameCard);
		int result = mapper.insertNameCard(nameCard);
		
		return result;
	}
	
	
	
	/************************ 파일업로드 / 사진텍스트 인식 ************************/
	
	//파일업로드
	public String fileService(MultipartFile uploadFile) {
		
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid+"_"+uploadFile.getOriginalFilename();
		
		File saveFile = new File(UPLOADPATH,saveFileName);
		try {
			uploadFile.transferTo(saveFile);
			String resurt = vision(saveFileName);
			return resurt;
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
