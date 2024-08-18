/*
  Warnings:

  - You are about to drop the `UserSubCategory` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "UserSubCategory" DROP CONSTRAINT "UserSubCategory_subCategoryId_fkey";

-- DropForeignKey
ALTER TABLE "UserSubCategory" DROP CONSTRAINT "UserSubCategory_userId_fkey";

-- DropTable
DROP TABLE "UserSubCategory";

-- CreateTable
CREATE TABLE "_SubCategoryToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_SubCategoryToUser_AB_unique" ON "_SubCategoryToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_SubCategoryToUser_B_index" ON "_SubCategoryToUser"("B");

-- AddForeignKey
ALTER TABLE "_SubCategoryToUser" ADD CONSTRAINT "_SubCategoryToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "SubCategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SubCategoryToUser" ADD CONSTRAINT "_SubCategoryToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
