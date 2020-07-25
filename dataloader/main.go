package main

import (
	"encoding/csv"
	"fmt"
	"io"
	"log"
	"os"
	"strconv"
	"strings"
	"time"
)

// HealthRecord is a single row of HealthKit data exported from HealthExport
type HealthRecord struct {
	Date                   time.Time
	ActiveEnergy           float64
	ExerciseTime           int64
	PushCount              int64
	HoursAsleep            int64
	HoursInBed             int64
	StepCount              int64
	DistanceWalkingRunning float64
}

func main() {
	var (
		rowCount      int64          = 0
		headers       map[string]int = make(map[string]int)
		healthRecords []HealthRecord = []HealthRecord{}
	)

	f, err := os.Open("dennis-export-07-25.csv")
	if err != nil {
		log.Fatal(err)
		return
	}

	r := csv.NewReader(f)

	for {
		record, err := r.Read()
		if err == io.EOF {
			break
		}

		if err != nil {
			log.Fatal(err)
		}

		fmt.Println(record)
		if rowCount == 0 {
			headers = parseHeaders(record)
			rowCount++
			fmt.Println(headers)
		} else {
			healthRecord, err := parseBodyRow(record, headers)
			if err != nil {
				fmt.Printf("failed to parse row. err=%+v", err)
				continue
			}
			healthRecords = append(healthRecords, healthRecord)
		}
	}

	fmt.Println(healthRecords)
}

// constants for the header column names
const (
	HeaderDate                   = "Date"
	HeaderActiveEnergy           = "Active Energy (kcal)"
	HeaderExerciseTime           = "Apple Exercise Time (min)"
	HeaderPushCount              = "Push Count (count)"
	HeaderHoursAsleep            = "Sleep Analysis [Asleep] (hours)"
	HeaderHoursInBed             = "Sleep Analysis [In Bed] (hours)"
	HeaderStepCount              = "Step Count (count)"
	HeaderDistanceWalkingRunning = "Walking + Running Distance (mi)"
)

// YYYYMMDD is a time format just for year, month, and date
const YYYYMMDD = "2006-01-02"

func parseHeaders(r []string) map[string]int {
	m := make(map[string]int)
	for i, name := range r {
		m[strings.Trim(name, " ")] = i
	}

	return m
}

func parseBodyRow(r []string, headers map[string]int) (h HealthRecord, err error) {
	i, ok := headers["Date"]
	if ok && r[i] != "" {
		h.Date, err = time.Parse(YYYYMMDD, getData(r[i]))
		if err != nil {
			return h, err
		}
	}

	i, ok = headers[HeaderActiveEnergy]
	if ok && r[i] != "" {
		h.ActiveEnergy, err = strconv.ParseFloat(getData(r[i]), 64)
		if err != nil {
			return h, err
		}
	}

	i, ok = headers[HeaderExerciseTime]
	if ok && r[i] != "" {
		h.ExerciseTime, err = strconv.ParseInt(getData(r[i]), 10, 64)
		if err != nil {
			return h, err
		}
	}

	i, ok = headers[HeaderPushCount]
	if ok && r[i] != "" {
		h.PushCount, err = strconv.ParseInt(getData(r[i]), 10, 64)
		if err != nil {
			return h, err
		}
	}

	i, ok = headers[HeaderHoursAsleep]
	if ok && r[i] != "" {
		h.HoursAsleep, err = strconv.ParseInt(getData(r[i]), 10, 64)
		if err != nil {
			return h, err
		}
	}

	i, ok = headers[HeaderHoursInBed]
	if ok && r[i] != "" {
		h.HoursInBed, err = strconv.ParseInt(getData(r[i]), 10, 64)
		if err != nil {
			return h, err
		}
	}

	i, ok = headers[HeaderStepCount]
	if ok && r[i] != "" {
		h.StepCount, err = strconv.ParseInt(getData(r[i]), 10, 64)
		if err != nil {
			return h, err
		}
	}

	i, ok = headers[HeaderDistanceWalkingRunning]
	if ok && r[i] != "" {
		h.DistanceWalkingRunning, err = strconv.ParseFloat(getData(r[i]), 64)
		if err != nil {
			return h, err
		}
	}

	return
}

func getData(s string) string {
	return strings.Trim(s, " ")
}
