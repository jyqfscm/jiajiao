package com.jiajiao.service.impl;

import com.jiajiao.bean.Evaluation;
import com.jiajiao.dao.EvaluationDao;
import com.jiajiao.service.EvaluationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EvaluationServiceImpl implements EvaluationService {

    @Autowired
    private EvaluationDao evaluationDao;

    @Override
    public boolean submitEvaluation(Evaluation evaluation) {
        return evaluationDao.saveEvaluation(evaluation) > 0;
    }
}
