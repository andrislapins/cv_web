package com.andrefeuille.cv_web_backend.jobs;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JobRepository extends JpaRepository<Job, Long> {
    // Optional: Custom query to find current jobs (no end_time)
    List<Job> findByEndTimeIsNull();
}
