/*
  Warnings:

  - A unique constraint covering the columns `[lng,lat]` on the table `tweet_location` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "tweet_location_lat_key";

-- DropIndex
DROP INDEX "tweet_location_lng_key";

-- CreateIndex
CREATE UNIQUE INDEX "tweet_location_lng_lat_key" ON "tweet_location"("lng", "lat");
