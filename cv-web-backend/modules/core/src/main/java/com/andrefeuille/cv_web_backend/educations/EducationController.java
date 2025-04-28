package com.andrefeuille.cv_web_backend.educations;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RestController
@RequestMapping("/api/v1/educations")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
@Slf4j
public class EducationController {

    private final EducationService educationService;

    @GetMapping
    public ResponseEntity<List<Education>> getAllEducations() {
        log.info("Fetching all educations");
        List<Education> educations = educationService.getAllEducations();
        return ResponseEntity.ok(educations);
    }

    @GetMapping("/current")
    public ResponseEntity<List<Education>> getCurrentEducations() {
        log.info("Fetching current education");
        return ResponseEntity.ok(educationService.getCurrentEducations());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Education> getEducationById(@PathVariable Long id) {
        log.info("Fetching education by id {}", id);
        return educationService.getEducationById(id)
                .map(education -> ResponseEntity.ok(education))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Education> createEducation(@RequestBody Education education) {
        log.info("Creating an education");
        Education saved = educationService.saveEducation(education);
        return ResponseEntity.status(HttpStatus.CREATED).body(saved);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEducation(@PathVariable Long id) {
        log.info("Deleting an education by id {}", id);
        educationService.deleteEducation(id);
        return ResponseEntity.noContent().build();
    }
}