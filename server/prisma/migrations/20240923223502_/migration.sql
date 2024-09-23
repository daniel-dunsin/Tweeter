/*
  Warnings:

  - A unique constraint covering the columns `[parentTweetId]` on the table `tweets` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[childTweetId]` on the table `tweets` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "tweets" ADD COLUMN     "childTweetId" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "tweets_parentTweetId_key" ON "tweets"("parentTweetId");

-- CreateIndex
CREATE UNIQUE INDEX "tweets_childTweetId_key" ON "tweets"("childTweetId");
