package com.ccnc.cube.user;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.common.Team;

@Repository
public interface UserRepository extends JpaRepository<Users, String> {

	List<Users> findByUserTeamId(Team userTeam);

	Users findByUserNum(String userNum);

	Users findByUserMobile(String userMobile);

	Users findByUserEmailEx(String userEmailEx);
	
	Users findByUserEmail(String userEmail);
	
	List<Users> findByUserNameContaining(String userName);
	
	List<Users> findByuserName(String userName);
	
}
