package models

import "time"

type Post struct {
	Id int
	UserId int
	Title string
	Url string
	Content string
	Tags string
	Views int
	IsTop int8
	Created time.Time
	Updated time.Time
	CategoryId int
	Status int8
	Types int8
	Info string
	Image string
}

func (m *Post) TableName() string {
	return TableName("post")
}
