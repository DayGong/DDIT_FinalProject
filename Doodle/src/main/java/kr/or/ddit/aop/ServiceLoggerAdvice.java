package kr.or.ddit.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Aspect
public class ServiceLoggerAdvice {
	// Before어드바이스 : 조인 포인트 전에 실행됨. 예외가 발생하는 경우만 제외하고 항상 실행됨
	@Before("execution(* kr.or.ddit.*..*(..))")
	public void startLog(JoinPoint jp) {
		log.debug("startLog");
		
		// .getSignature() : 어떤 클래스의 어떤 메서드가 실행되었는지 보여줌. 파라미터 타입은 무엇인지 보여줌
		// kr.or.ddit.service.BoardService.register(BoardVO)
		log.debug("startLog: " + jp.getSignature());
		
		// .getArgs() : 전달 된 파라미터 정보를 보여줌
		// [BoardVO [boardNo=127,title=개똥이]]
		log.debug("startLog: " + Arrays.deepToString(jp.getArgs()));
	}
	
	// AfterReturning 어드바이스
	// 조인 포인트가 정상적으로 종료한 후에 실행됨. 예외 발생 시 실행 안됨
	@AfterReturning("execution(* kr.or.ddit.*..*(..))")
	public void logReturning(JoinPoint jp) {
		log.debug("logReturning");
		
		//.getSignature() : 어떤 클래스의 어떤 메서드가 실행되었는지 보여줌. 파라미터 타입은 무엇인지 보여줌
		// kr.or.ddit.service.BoardService.register(BoardVO)
		log.debug("logReturning: " + jp.getSignature());
	}
	
	// After Throwing 어드바이스
	// 조인 포인트에서 예외 발생 시 실행. 예외가 발생 안 되면 실행 안 됨
	@AfterThrowing(pointcut="execution(* kr.or.ddit.*..*(..))", throwing="e")
	public void logException(JoinPoint jp, Exception e) {
		log.debug("logException");
		
		log.debug("logException: " + jp.getSignature());
		
		// 예외 메시지를 보여줌
		log.debug("logException: " + e);
	}
	
	// After 어드바이스
	// 조인 포인트 완료 후 실행. 예외 발생이 되더라도 항상 실행 됨
	@After("execution(* kr.or.ddit.*..*(..))")
	public void endLog(JoinPoint jp) {
		log.debug("endLog");
		
		// .getSignature() : 어떤 클래스의 어떤 메서드가 실행되었는지 보여줌. 파라미터 타입은 무엇인지 보여줌
		// kr.or.ddit.service.BoardService.register(BoardVO)
		log.debug("endLog: " + jp.getSignature());
		
		// .getArgs() : 전달 된 파라미터 정보를 보여줌
		// [BoardVO [boardNo=127,title=개똥이]]
		log.debug("endLog: " + Arrays.deepToString(jp.getArgs()));
	}
	
	// ProceedingJoinPoint : around 어드바이스에서 사용함
	@Around("execution(* kr.or.ddit.*..*(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
		// 메소드 실행 직전 시간 체킹
		long startTime = System.currentTimeMillis();
		
		// .getArgs() : 전달 된 파라미터 정보를 보여줌
		log.debug("pjpStart: " + Arrays.toString(pjp.getArgs()));
		
		// 메소드(createPost(ItemVO itemVO)) 실행
		Object result = pjp.proceed();
		
		// 메소드 실행 직후 시간 체킹
		long endTime = System.currentTimeMillis();
		
		log.debug("pjpEnd: " + Arrays.toString(pjp.getArgs()));
		
		// 메소드 실행 직후 시간 - 메소드 실행 직전 시간 = 메소드 실행 시간
		log.debug(pjp.getSignature().getName() + " : " + (endTime - startTime));
		
		return result;
	}
}
