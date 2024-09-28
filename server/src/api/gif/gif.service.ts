import { GiphyFetch } from '@giphy/js-fetch-api';
import { Inject, Injectable } from '@nestjs/common';
import { GIPHY_PROVIDER } from './giphy.provider';
import { GetGifsQuery } from './dtos';
import { UtilService } from 'src/shared/utils/utils.service';
import { isEmpty } from 'lodash';

@Injectable()
export class GifService {
  constructor(
    @Inject(GIPHY_PROVIDER) private readonly giphy: GiphyFetch,
    private readonly utilService: UtilService,
  ) {}

  async getGifs(query: GetGifsQuery) {
    const { skip, limit } = this.utilService.resolvePaginationQuery(query);

    let data, pagination;

    console.log(query.search);
    console.log(query);

    if (!query.search || isEmpty(query.search.trim())) {
      const response = await this.giphy.trending({ offset: skip, limit });

      data = response.data;
      pagination = response.pagination;
    } else {
      const response = await this.giphy.search(query.search, {
        offset: skip,
        limit,
      });

      data = response.data;
      pagination = response.pagination;
    }

    const totalPages = Math.ceil(pagination.total_count / limit);
    const count = pagination.count;

    return {
      message: 'trending gifs fetched',
      data,
      meta: {
        totalPages,
        count,
      },
    };
  }
}
