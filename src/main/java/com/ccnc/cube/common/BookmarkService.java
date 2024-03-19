package com.ccnc.cube.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookmarkService {
	
	@Autowired
	private BookmarkRepository bookmarkRepository;

}
