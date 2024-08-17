/*
  Warnings:

  - You are about to drop the `UserCategory` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "UserCategory" DROP CONSTRAINT "UserCategory_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "UserCategory" DROP CONSTRAINT "UserCategory_userId_fkey";

-- DropTable
DROP TABLE "UserCategory";

-- CreateTable
CREATE TABLE "UserSubCategory" (
    "id" TEXT NOT NULL,
    "subCategoryId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "UserSubCategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubCategory" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "SubCategory_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "UserSubCategory" ADD CONSTRAINT "UserSubCategory_subCategoryId_fkey" FOREIGN KEY ("subCategoryId") REFERENCES "SubCategory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSubCategory" ADD CONSTRAINT "UserSubCategory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
