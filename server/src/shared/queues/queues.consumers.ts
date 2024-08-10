import { Processor, Process } from '@nestjs/bull';
import { AppQueues } from './queues.enum';
import { APP_QUEUE } from '../events/event.enum';
import { Job } from 'bull';
import { Inject } from '@nestjs/common';
import { MailService } from '../mail/mail.service';
import { ISendMailOptions } from '../mail/interfaces/mail.interface';

@Processor({ name: APP_QUEUE })
export class MailQueue {
  constructor(@Inject(MailService) private readonly mailService: MailService) {}

  @Process(AppQueues.sendMail)
  async mailQueue(job: Job<ISendMailOptions>) {
    console.log(`Process job ${job.id}....`);

    await this.mailService.sendMail(job.data);
  }
}
