package com.ccnc.cube.reservation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MeetingroomRepository extends JpaRepository<Meetingroom, Integer> {

}
