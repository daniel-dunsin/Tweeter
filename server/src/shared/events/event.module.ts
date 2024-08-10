import { Module } from '@nestjs/common';
import { EventService } from './event.service';
import { QueueModule } from '../queues/queue.module';

@Module({
  imports: [QueueModule],
  providers: [EventService],
  exports: [EventService],
})
export class EventModule {}
