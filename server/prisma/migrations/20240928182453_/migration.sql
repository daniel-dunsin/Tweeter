/*
  Warnings:

  - You are about to drop the column `childTweetId` on the `tweets` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "tweets_childTweetId_key";

-- AlterTable
ALTER TABLE "tweets" DROP COLUMN "childTweetId";
