package com.ikuyonn.project.nameCard.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.ikuyonn.project.nameCard.vo.NameCard;

public interface NameCardMapper {
	public int insertNameCard(NameCard nameCard);
	public int getTotal(Map<String, String> search);
	public NameCard selectNameCard(NameCard nameCard);
	public ArrayList<NameCard> selectNameCardList(RowBounds rowBounds,Map<String, String> search);
	public int deleteNameCard(NameCard nameCard);
	public int upDateNameCard(NameCard nameCard);
	public String selectEmailAddress(NameCard nameCard);
	public ArrayList<NameCard> getAllNC(String userID);
	public ArrayList<NameCard> getMember(NameCard nc);
	public ArrayList<String> getMailByhUserID(String userID);
	public ArrayList<NameCard> selectNameCardList(Map<String, String> search);
}
