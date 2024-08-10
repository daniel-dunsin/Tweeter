import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { APP_QUEUE } from '../events/event.enum';
import { join } from 'path';
import { MailModule } from '../mail/mail.module';

@Module({
  imports: [
    BullModule.registerQueue({
      name: APP_QUEUE,
      processors: [join(__dirname, 'queues.consumers.js')],
    }),
    MailModule,
  ],
  exports: [BullModule],
})
export class QueueModule {}
