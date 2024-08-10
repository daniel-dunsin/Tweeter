import { Injectable } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { APP_QUEUE, AppEvents } from './event.enum';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';
import { AppQueues } from '../queues/queues.enum';
import {
  ISendBulkMailOptions,
  ISendMailOptions,
} from '../mail/interfaces/mail.interface';

@Injectable()
export class EventService {
  constructor(@InjectQueue(APP_QUEUE) private readonly appQueue: Queue) {}

  @OnEvent(AppEvents.sendMail)
  async sendMail(sendMailDto: ISendMailOptions) {
    await this.appQueue.add(AppQueues.sendMail, sendMailDto, {});
  }

  @OnEvent(AppEvents.sendBulkMail)
  async sendBulkMail(sendBulkMailDto: ISendBulkMailOptions) {
    await this.appQueue.addBulk(
      sendBulkMailDto.to.map(({ email, context }) => ({
        name: AppQueues.sendMail,
        data: {
          to: email,
          context,
          subject: sendBulkMailDto.subject,
          template: sendBulkMailDto.template,
        },
      })),
    );
  }
}
