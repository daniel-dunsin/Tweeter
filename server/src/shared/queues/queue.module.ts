import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { APP_QUEUE } from '../events/event.enum';
import { MailModule } from '../mail/mail.module';
import { AppQueue } from './queues.consumers';

@Module({
  imports: [
    BullModule.registerQueue({
      name: APP_QUEUE,
    }),
    MailModule,
  ],
  exports: [BullModule],
  providers: [AppQueue],
})
export class QueueModule {}
