package kr.or.ddit.aop;

import java.lang.reflect.Field;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.spi.LoggerFactoryBinder;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.stereotype.Component;
// 스프링 프레임웍은 설정파일 내에 선언된 빈 선언 또는
// Component-scan 설정에 따라 @Controller, @service,
// @Repository, @Component가 선언된 클래스들을 빈으로 등록하기 위해
// DefaultBeanProcessor(implements BeanPostProcessor)를 활용
import org.springframework.util.ReflectionUtils;
import org.springframework.util.ReflectionUtils.FieldCallback;

@Component
public class LoggerInjector implements BeanPostProcessor{
	
	// 파라메터1 : 금번 빈으로 등록완료된 빈 객체 DI.
	// 파라메터2 : 금번 빈으로 등록완료된 빈의 이름 DI.
	@Override
	public Object postProcessBeforeInitialization(Object beanClazz, String beanName)
			throws BeansException {
		// 빈등록이 완료되면 콜백
		return beanClazz;
	}

	// 파라메터1 : 금번 빈으로 등록 착수시 빈 객체 DI.
	// 파라메터2 : 금번 빈으로 등록 착수시 빈의 이름 DI.
	@Override
	public Object postProcessAfterInitialization(final Object beanClazz, String beanName)
			throws BeansException {
		// beanClazz.getClass() : 빈으로 들어온 클래스의 타입
		// 1. 빈 등록 대상의 클래스를 빈 등록 전에 postProcessAfterInitialization() 콜백
		// 2. 빈 등록 대상 클래스 내 선언된 모든 전역변수에 반복적으로 접근하기 위해
		//    ReflectionUtils 활용 (전역변수가 5개라면 doWith필드가 3번 호출된다.)
		//    doWithFields뿐만아니라 doWithMethod도 있다(메서드도 접근가능)
		ReflectionUtils.doWithFields(beanClazz.getClass(), new FieldCallback() {
			
			@Override
			public void doWith(Field field) throws IllegalArgumentException,
					IllegalAccessException {
//				// 해당 전역변수의 접근 지정자가 private이어도 접근될 수 있다.
				ReflectionUtils.makeAccessible(field);
				// null이 아니라면 Annotation이 붙어있는것이다.
				if(field.getAnnotation(Loggable.class) != null){
					Logger logger = LoggerFactory.getLogger(beanClazz.getClass());
					field.set(beanClazz, logger);
				}
			}
		});
		return beanClazz;
	}

}
