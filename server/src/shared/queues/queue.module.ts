import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { MailModule } from '../mail/mail.module';
import { AppQueue } from './queues.consumers';
import { APP_QUEUE } from './queues.enum';

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
