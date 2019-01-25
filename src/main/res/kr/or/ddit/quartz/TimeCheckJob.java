package kr.or.ddit.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class TimeCheckJob extends QuartzJobBean {

	@Override
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		System.out.println("timeCheckJob content : " 
			 + new SimpleDateFormat("yyyy/MM/dd hh:mm:ss").format(new Date()));
	}

}
