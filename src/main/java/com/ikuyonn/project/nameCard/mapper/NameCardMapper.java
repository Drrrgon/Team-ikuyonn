package com.ikuyonn.project.nameCard.mapper;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.ikuyonn.project.nameCard.vo.NameCard;

public interface NameCardMapper {
	public int insertNameCard(NameCard nameCard);
	public int getTotal(String searchText);
	public ArrayList<NameCard> selectNameCardList(RowBounds rowBounds,String searchText);
}
