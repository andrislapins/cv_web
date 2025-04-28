package com.andrefeuille.cv_web_backend.educations;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

@Service
public class EducationService {
    private final EducationRepository educationRepository;

    public EducationService(EducationRepository educationRepository) {
        this.educationRepository = educationRepository;
    }

    public List<Education> getAllEducations() {
        return educationRepository.findAll();
    }

    public List<Education> getCurrentEducations() {
        return educationRepository.findByEndTimeIsNull();
    }

    public Optional<Education> getEducationById(Long id) {
        return educationRepository.findById(id);
    }

    public Education saveEducation(Education education) {
        return educationRepository.save(education);
    }

    public void deleteEducation(Long id) {
        educationRepository.deleteById(id);
    }
}
