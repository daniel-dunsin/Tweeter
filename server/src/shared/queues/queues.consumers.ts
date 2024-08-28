import { Processor, Process, OnQueueActive } from '@nestjs/bull';
import { APP_QUEUE, AppQueues } from './queues.enum';
import { Job } from 'bull';
import { Inject } from '@nestjs/common';
import { MailService } from '../mail/mail.service';
import { ISendMailOptions } from '../mail/interfaces/mail.interface';

@Processor({ name: APP_QUEUE })
export class AppQueue {
  constructor(@Inject(MailService) private readonly mailService: MailService) {}

  @Process(AppQueues.sendMail)
  async mailQueue(job: Job<ISendMailOptions>) {
    await this.mailService.sendMail(job.data);
  }

  @OnQueueActive()
  onActive(job: Job) {
    console.log(
      `Processing job ${job.id} of type ${job.name} with data ${job.data}...`,
    );
  }
}
