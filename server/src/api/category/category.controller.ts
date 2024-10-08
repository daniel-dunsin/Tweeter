import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { CreateCategoryDto, CreateSubCategoryDto } from './dtos';
import { CategoryProvider } from './category.provider';
import { IsPublic } from 'src/core/decorators/auth.decorator';

@Controller('category')
@ApiTags('category')
@ApiBearerAuth()
export class CategoryController {
  constructor(private readonly categoryProvider: CategoryProvider) {}

  @Post()
  async createCategory(@Body() createCategoryDto: CreateCategoryDto) {
    return await this.categoryProvider.createCategory(createCategoryDto);
  }

  @IsPublic()
  @Get()
  async getCategories() {
    return await this.categoryProvider.getCategories();
  }

  @IsPublic()
  @Get(':categoryId')
  async getCategory(@Param('categoryId') categoryId: string) {
    return await this.categoryProvider.getCategory(categoryId);
  }

  @Post('sub')
  async createSubCategory(@Body() createSubCategoryDto: CreateSubCategoryDto) {
    return await this.categoryProvider.createSubCategory(createSubCategoryDto);
  }

  @IsPublic()
  @Get(':categoryId/sub')
  async getSubCategories(@Param('categoryId') categoryId: string) {
    return await this.categoryProvider.getSubCategories(categoryId);
  }

  @IsPublic()
  @Get('sub/:subCategoryId')
  async getSubCategory(@Param('subCategoryId') subCategoryId: string) {
    return await this.categoryProvider.getSubCategory(subCategoryId);
  }
}
