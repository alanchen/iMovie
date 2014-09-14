//
//  IMEnumType.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

typedef NS_ENUM(NSInteger, IMMovieListType) {
    IMMovieListTypeUnknown = -1,
    IMMovieListTypeTPRank = 0,
    IMMovieListTypeThisWeek = 1,
    IMMovieListTypeIncoming = 2,
    IMMovieListTypeInTheater = 3,
};

typedef NS_ENUM(NSInteger, IMMovieArticleType) {
    IMMovieArticleTypeUnknown = -1,
    IMMovieArticleTypeGood = 0,
    IMMovieArticleTypeNormal = 1,
    IMMovieArticleTypeBad = 2,
};


typedef NS_ENUM(NSInteger, IMMovieListSort) {
    IMMovieListSortUnknown = -1,
    IMMovieListSortHitto = 0,
    IMMovieListSortGood = 1,
    IMMovieListSortBad = 2,
    IMMovieListSortTPRank = 3,
    IMMovieListSortIMDB = 4,
    IMMovieListSortIncoming = 5

};
