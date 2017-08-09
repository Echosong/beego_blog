package models

import "time"

type Comment struct {
	Id    int
	Username  string
	Content string
	Created time.Time
	PostId int
	Ip string
}

func (m *Comment) TableName() string {
	return TableName("comment")
}