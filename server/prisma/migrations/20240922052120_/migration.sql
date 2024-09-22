/*
  Warnings:

  - Added the required column `slug` to the `hashtags` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "hashtags" ADD COLUMN     "slug" TEXT NOT NULL;
