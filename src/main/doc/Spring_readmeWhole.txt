Spring 강의 목차
설치 : 전자정부 프레임웍 외 이클립스 대상 스프링 및 메이븐 설정
      1.1 plug-in 설치 : 
		 1) Maven Integration for WTP(incuvation) 설치
         2) STS(Springsource Tool Suite) for eclipse 버젼 선택으로 설치
		 3) maven 에러 발생시 windows -> preferences -> Maven -> WTP integration -> 모두 체크
		 
      1.2 라이브러리 다운로드 : 
         http://www.springsource.org/download/community
         http://spring.io/tools/sts/all
         1) spring-framework-3.1.2.RELEASE-with-docs.zip
         2) spring-framework-3.0.2.RELEASE-dependencies.zip
         
      1.3 사이트 개편에따른 다운로드
         http://repo.spring.io/release/org/springframework/spring
         org - spring framework - spring - 원하는 버전 - 버전.RELEASE-dist.zip 다운로드

      1.4 프로젝트 생성 -> Spring Project -> 프로젝트 명 추가 -> Templates -> Simple Spring Maven

      1.5 프로젝트 Properties -> Java Build Path -> Source -> [Add Folder] -> [Create New Folder] -> conf 추가 및 선택
                                                    [Add Folder] -> [Create New Folder] -> res 추가 및 선택 

1. factoryPattern
   * IoC(DL:Dependency Lookup 및 DI:Dependency Injection 구현)

2. 프로젝트에 스프링 설정파일 작성 및 설정파일 로딩
   
   2.1 클래스 패스 외부에 존재하는 applicationContext.xml 로딩(applicationContext.xml)
       2.1.1 설정파일 내 빈 선언에따른 id와 name 속성의 정의
       2.1.2 설정파일 내 빈의 선언과 IoC(DL|DI) 및 해당 빈 취득 처리
   
   2.2 클래스 패스내 존재하는 applicationContext.xml 로딩
       2.2.1 asiaApplicationContext.xml
	             가) 설정파일 내 factory-bean과 factory-method 선언 및 활용
	             나) 설정파일 내 enum의 활용
	             다) BeanFactory를 통한 설정파일 내 선언된 빈의 인스턴스 취득과
	             ApplicationContext를 통한 설정파일 내 선언된 빈의 인스턴스 취득의 비교
   
   	   2.2.2 usaApplicationContext.xml
                   가) lazy-init 속성 설정을 통한 설정파일 내 빈의 지연 생성
       
       2.2.3 headOfficeApplicationContext.xml
                   가) 2.4.1 설정파일 내 import 속성을 활용한 다수의 설정파일 통합 
                   나) 추상 팩토리 패턴의 적용        

   2.3 클래스 패스내 존재하는 다수의 설정파일의 통합 ApplicationContext 생성
       2.3.1 EnBlocClassPathXmlApplicationContextMain.java

3. bean의 속성
   3.1 <constructor-arg>, <property>선언 및 해당 빈의 생성자 및 속성 대상 주입(injectToConstructNProperty.xml)
   3.2 <bean>의 init-method, destroy-method, abstract, parent, depends-on 속성 활용과 p namespace의 활용(attributeInBeanElement.xml)
   3.3 <bean>의 scope, autowire 속성 활용(autowireInBeanElement.xml)
       
4. bean에서 활용가능한 자원의 취득
   4.1 빈의 라이프 사이클 확장, 사용자정의 BeanPostProcessor의 활용, BeanFactory, ApplicationContext, ResourceLoader 자원의 취득
       (springFrameworkResourceInBean.xml)
   4.2 ApplicationContext의 State Event 청취를위한 빈 설정(applicationContextEventPublishing.xml)        
   4.3 CustomApplicationEvent Publishing 및 Quartz의 활용(customApplicationEventNQuartz.xml)

5. propertyPlaceHolder를 활용한 Apache Common Email 송신.(propertyFileUsed.xml)
   5.1 <context:annotation-config> 선언

6. Annotation의 활용(<context:annotation-config>의 활용)
   Navigator View를 활용해 zero3.inject 팩키지 내 action, service, dao, ibatis 패키지와
   zero2.applicationContext 팩키지 내 vo 팩키지를 zero6.annotation 팩키지 하위로 복사해 위치시키고 에러 대응.
   
   6.1 @Required Annotation(requiredAnnotationContext.xml)
   6.2 @Autowired Annotation(autowiredAnnotationContext.xml) 
   6.3 JSR-250 스팩의 Annotation(jsr250AnnotationContext.xml)
   6.4 @Configuration의 활용.
       <dependency>
			<groupId>cglib</groupId>
			<artifactId>cglib</artifactId>
			<version>2.2.2</version>
		</dependency>  추가 
		
       <!-- @Configuration : xml기반의 스프링 설정을 자바 클래스로 구현하며 상기 어노테이션 활용이 가능. -->
 	   <bean class="org.springframework.context.annotation.ConfigurationClassPostProcessor"></bean> 클래스 로딩은
 	   AnnotationConfigApplicationContext 생성시 로딩되어 @Configuration 활용되며, 
       zero6/context/ConfigurationAnnotationConfig1.java
       
       6.4.1 LprodAction  -> LprodServiceImpl  -> LprodDaoImpl 
             ProdActon    -> ProdServcieImpl   -> ProdDaoImpl     => 데이타베이스
             MemberAction -> MemberServiceImpl -> MemberDaoImpl
             
   6.5 상기(6.1부터 6.2항까지의 Annotation 활용을위해 로딩되어야하는 모든 빈들은  <context:annotation-config>로 활용 팩키징 활용될수 있음.
       (annotationConfigApplicationContext.xml)
       
7. AOP(Aspect Oriented Programming)
   7.1 AspectJ Annotation(aspectjAnnotationAOP.xml)
   7.2 xml base AOP(xmlBaseAOP.xml)

8. 설정파일 구조화 및 트랜잭션 설정
   application-main.xml
   application-datasource.xml
   application-transaction.xml
   application-commons.xml