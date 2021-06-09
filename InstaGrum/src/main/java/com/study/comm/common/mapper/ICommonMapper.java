package com.study.comm.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICommonMapper {
	List<CommonDto> listMapper();
}
