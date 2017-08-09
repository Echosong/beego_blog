package models

type Config struct {
	Id    int
	Name  string
	Value string
}

func (m *Config) TableName() string {
	return TableName("config")
}