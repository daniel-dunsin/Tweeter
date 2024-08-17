import { Injectable } from '@nestjs/common';
import { Prisma, PrismaClient } from '@prisma/client';

@Injectable()
export class CategoryService {
  constructor(private readonly prisma: PrismaClient) {}

  async createCategory(data: Prisma.CategoryCreateInput) {
    return this.prisma.category.create({ data });
  }

  async getCategory(where: Prisma.CategoryWhereInput) {
    return this.prisma.category.findFirst({ where });
  }

  async getCategories(where: Prisma.CategoryWhereInput) {
    return this.prisma.category.findMany({ where });
  }

  async createSubCategory(data: Prisma.SubCategoryCreateInput) {
    return this.prisma.subCategory.create({ data });
  }

  async getSubCategories(where: Prisma.SubCategoryWhereInput) {
    return this.prisma.subCategory.findMany({ where });
  }

  async getSubCategory(where: Prisma.SubCategoryWhereInput) {
    return this.prisma.subCategory.findFirst({ where });
  }
}
