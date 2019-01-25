package kr.or.ddit.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;

import kr.or.ddit.member.service.IMemberService;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class DateCheckJob extends AbstractQuartzJob{

	@Override
	protected void executeJob(JobExecutionContext jobExecution) {
		// 스프링 빈으로 등록되지 않은 일반 잡클래스에서
		// 스프링 빈으로 등록된 특정빈의 인스턴스를 DI.
		IMemberService service = (IMemberService) super.getBean("memberService");
		// service.insertMemberInfo(memberInfo)
		
		System.out.println("timeCheckJob content : " 
				 + new SimpleDateFormat("yyyy/MM/dd hh:mm:ss").format(new Date()));
	}

}
