import { Injectable, OnModuleInit } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/shared/prisma/prisma.service';

const CATEGORIES = require('../../../src/shared/seeds/categories.json');

@Injectable()
export class CategoryService implements OnModuleInit {
  constructor(private readonly prisma: PrismaService) {}

  onModuleInit() {
    this.seedCategories().then(() => console.log('Done'));
  }

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

  async seedCategories() {
    const count = await this.prisma.category.count();

    if (!count) {
      const categories = CATEGORIES;
      await Promise.all(
        categories.map(async ({ subCategories, ...category }) => {
          const { id } = await this.prisma.category.create({
            data: category as Prisma.CategoryCreateInput,
          });

          return Promise.all(
            subCategories.map(async (subcategory) =>
              this.prisma.subCategory.create({
                data: { categoryId: id, ...subcategory },
              }),
            ),
          );
        }),
      );
    }
  }
}
