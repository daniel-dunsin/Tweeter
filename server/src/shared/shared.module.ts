import { Module } from '@nestjs/common';
import { PrismaModule } from './prisma/prisma.module';
import { UtilsModule } from './utils/utils.module';
import { EventModule } from './events/event.module';
import { QueueModule } from './queues/queue.module';

@Module({
  imports: [PrismaModule, UtilsModule, EventModule, QueueModule],
  exports: [UtilsModule, EventModule, PrismaModule],
})
export class SharedModule {}
