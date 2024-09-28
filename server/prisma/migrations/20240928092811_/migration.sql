/*
  Warnings:

  - You are about to drop the column `locationId` on the `tweets` table. All the data in the column will be lost.
  - You are about to drop the `tweet_location` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "tweets" DROP CONSTRAINT "tweets_locationId_fkey";

-- AlterTable
ALTER TABLE "tweets" DROP COLUMN "locationId";

-- DropTable
DROP TABLE "tweet_location";
