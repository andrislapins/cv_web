package com.andrefeuille.cv_web_backend.educations;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EducationRepository extends JpaRepository<Education, Long> {
    // Optional: Custom query to find current jobs (no end_time)
    List<Education> findByEndTimeIsNull();
}
