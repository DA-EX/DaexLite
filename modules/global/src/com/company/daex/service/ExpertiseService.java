package com.company.daex.service;


import com.company.daex.entity.Employee;

import java.util.UUID;

public interface ExpertiseService {
    String NAME = "daex_ExpertiseService";

    boolean FinalVersion(UUID id);
    String EGRZ(UUID id, String expertiseName);

    Employee GetEmployee(UUID id);
}