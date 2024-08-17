import { Module } from '@nestjs/common';
import { CategoryController } from './category.controller';
import { CategoryProvider } from './category.provider';
import { CategoryService } from './category.service';
import { SharedModule } from 'src/shared/shared.module';

@Module({
  imports: [SharedModule],
  controllers: [CategoryController],
  providers: [CategoryProvider, CategoryService],
  exports: [CategoryProvider, CategoryService],
})
export class CategoryModule {}
