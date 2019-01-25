package kr.or.ddit.quartz;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

public abstract class AbstractQuartzJob extends QuartzJobBean {
	private ApplicationContext applicationContext;
	
	@Override
	protected void executeInternal(JobExecutionContext jobExecution)
			throws JobExecutionException {
		this.applicationContext = (ApplicationContext) jobExecution.getJobDetail().getJobDataMap().get("applicationContext");
		executeJob(jobExecution);
	}
	
	protected Object getBean(String beanName) {
		return this.applicationContext.getBean(beanName);
		
	}
	
	protected abstract void executeJob(JobExecutionContext jobExecution);
}
