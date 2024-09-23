/*
  Warnings:

  - You are about to drop the column `tweetId` on the `tweet_location` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[lng]` on the table `tweet_location` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[lat]` on the table `tweet_location` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `locationId` to the `tweets` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "tweet_location" DROP CONSTRAINT "tweet_location_tweetId_fkey";

-- DropIndex
DROP INDEX "tweet_location_tweetId_key";

-- AlterTable
ALTER TABLE "tweet_location" DROP COLUMN "tweetId";

-- AlterTable
ALTER TABLE "tweets" ADD COLUMN     "locationId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "tweet_location_lng_key" ON "tweet_location"("lng");

-- CreateIndex
CREATE UNIQUE INDEX "tweet_location_lat_key" ON "tweet_location"("lat");

-- AddForeignKey
ALTER TABLE "tweets" ADD CONSTRAINT "tweets_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "tweet_location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
