import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/shared/prisma/prisma.service';

@Injectable()
export class CategoryService {
  constructor(private readonly prisma: PrismaService) {}

  async createCategory(data: Prisma.CategoryCreateInput) {
    return this.prisma.category.create({
      data,
      include: { subCategories: true },
    });
  }

  async getCategory(where: Prisma.CategoryWhereInput) {
    return this.prisma.category.findFirst({
      where,
      include: { subCategories: true },
    });
  }

  async getCategories(where: Prisma.CategoryWhereInput) {
    return this.prisma.category.findMany({
      where,
      include: { subCategories: true },
    });
  }

  async createSubCategory(data: Prisma.SubCategoryCreateInput) {
    return this.prisma.subCategory.create({
      data,
      include: { category: true },
    });
  }

  async getSubCategories(where: Prisma.SubCategoryWhereInput) {
    return this.prisma.subCategory.findMany({
      where,
      include: { category: true },
    });
  }

  async getSubCategory(where: Prisma.SubCategoryWhereInput) {
    return this.prisma.subCategory.findFirst({
      where,
      include: { category: true },
    });
  }
}
