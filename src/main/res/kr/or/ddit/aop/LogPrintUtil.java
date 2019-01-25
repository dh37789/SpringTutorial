package kr.or.ddit.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.springframework.stereotype.Component;

@Component("logPrintAspect")
public class LogPrintUtil {
	@Loggable
	public static Logger logger;
	
	// 스프링 프레임웍은 AOP 타겟 : 메서드 대상
	// Advice(Aspcet가 PointCut에 Weaving되는 시점) : 메서드 호출전,
	//											  메서드 종료후,
	//	                     					  메서드 호출 후 익셉션 발생 후,
	//		       								  메서드 호출 후와 종류 후
	public void theWholeJoinpointCallBefore(JoinPoint joinPoint){
		// 메서드 호출 전
		// 해당 joinPoint를 포함하는 빈 클래스의 팩키지명.클래스명 반환.
		String clazzName = joinPoint.getTarget().getClass().getName();
		String joinPointMethod = joinPoint.getSignature().getName();
				
		logger.debug("clazzName : {} | methodName : {}가 호출 되었습니다.", clazzName, joinPointMethod);
	}
	public void theWholeJoinpointCallAfter(JoinPoint joinPoint){
		// 메서드 종료 후
		// 해당 joinPoint를 포함하는 빈 클래스의 팩키지명.클래스명 반환.
		String clazzName = joinPoint.getTarget().getClass().getName();
		String joinPointMethod = joinPoint.getSignature().getName();
		
		logger.debug("clazzName : {} | methodName : {}가 종료됩니다.", clazzName, joinPointMethod);
	}
	public void theWholeJoinpointCallAfterThrowing(JoinPoint joinPoint, Exception ex){
		// 메서드 호출 후 익셉션 발생 이후
		// 해당 joinPoint를 포함하는 빈 클래스의 팩키지명.클래스명 반환.
		String clazzName = joinPoint.getTarget().getClass().getName();
		String joinPointMethod = joinPoint.getSignature().getName();
		
		logger.debug("clazzName : {} | methodName : {}가 호출 후 {} 익셉션이 발생되었습니다.", clazzName, joinPointMethod, ex.getMessage());
	}
	public Object theWholeJoinpointCallAround(ProceedingJoinPoint joinPoint) throws Throwable{
		// 메서드 호출 후 한번 그리고, 메서드 종료 후 한번
		// 해당 joinPoint를 포함하는 빈 클래스의 팩키지명.클래스명 반환.
		String clazzName = joinPoint.getTarget().getClass().getName();
		String joinPointMethod = joinPoint.getSignature().getName();
		
		logger.debug("clazzName : {} | methodName : {}가 호출 후....", clazzName, joinPointMethod);

		Object returnValue = joinPoint.proceed();

		logger.debug("clazzName : {} | methodName : {}가 종료되어요....", clazzName, joinPointMethod);
		
		return returnValue;
	}
}
