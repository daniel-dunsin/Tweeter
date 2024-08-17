import { Injectable, NotFoundException } from '@nestjs/common';
import { CategoryService } from './category.service';
import { CreateCategoryDto, CreateSubCategoryDto } from './dtos';

@Injectable()
export class CategoryProvider {
  constructor(private readonly categoryService: CategoryService) {}

  async createCategory(createCategoryDto: CreateCategoryDto) {
    let data = await this.categoryService.getCategory({
      name: createCategoryDto.name,
    });

    if (!data) {
      data = await this.categoryService.createCategory(createCategoryDto);
    }

    return {
      success: true,
      message: 'category created',
      data,
    };
  }

  async createSubCategory(createSubCategoryDto: CreateSubCategoryDto) {
    let data = await this.categoryService.getSubCategory({
      name: createSubCategoryDto.name,
      categoryId: createSubCategoryDto.categoryId,
    });

    if (!data) {
      data = await this.categoryService.createSubCategory(createSubCategoryDto);
    }

    return {
      success: true,
      message: 'subcategory created',
    };
  }

  async getCategory(categoryId: string) {
    const data = await this.categoryService.getCategory({ id: categoryId });

    if (!data) throw new NotFoundException('Category not found');

    return {
      success: true,
      message: 'Category retrieved successfully',
      data,
    };
  }

  async getSubCategory(subCategoryId: string) {
    const data = await this.categoryService.getSubCategory({
      id: subCategoryId,
    });
    if (!data) throw new NotFoundException('Subcategory not found');

    return {
      success: true,
      message: 'Subcategory retrieved successfully',
      data,
    };
  }

  async getCategories() {
    const data = await this.categoryService.getCategories({});

    return {
      success: true,
      message: 'Categories retrieved successfully',
      data,
    };
  }

  async getSubCategories(categoryId: string) {
    const data = await this.categoryService.getSubCategories({ categoryId });

    return {
      success: true,
      message: 'Subcategories retrieved successfully',
      data,
    };
  }
}
