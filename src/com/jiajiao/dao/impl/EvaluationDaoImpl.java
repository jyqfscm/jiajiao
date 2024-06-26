package com.jiajiao.dao.impl;

import com.jiajiao.bean.Evaluation;
import com.jiajiao.dao.EvaluationDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class EvaluationDaoImpl implements EvaluationDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public int saveEvaluation(Evaluation evaluation) {
        String sql = "INSERT INTO t_evaluation (teacherId, memberId, toId, oId, score, evaluationContent, evaluationTime) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, evaluation.getTeacherId(), evaluation.getMemberId(), evaluation.getToId(), evaluation.getOId(), evaluation.getScore(), evaluation.getEvaluationContent(), evaluation.getEvaluationTime());
    }
}
