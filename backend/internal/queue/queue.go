package queue

import (
	"log"
	"sync"
)

// Job represents a unit of work
type Job interface {
	Process() error
}

// WorkerPool manages a set of workers
type WorkerPool struct {
	JobQueue   chan Job
	MaxWorkers int
	wg         sync.WaitGroup
	Quit       chan bool
}

// NewWorkerPool initializes the pool
func NewWorkerPool(maxWorkers int, bufferSize int) *WorkerPool {
	return &WorkerPool{
		JobQueue:   make(chan Job, bufferSize),
		MaxWorkers: maxWorkers,
		Quit:       make(chan bool),
	}
}

// Start spawns the workers
func (wp *WorkerPool) Start() {
	for i := 0; i < wp.MaxWorkers; i++ {
		wp.wg.Add(1)
		go func(workerID int) {
			defer wp.wg.Done()
			log.Printf("Worker %d started\n", workerID)
			
			for {
				select {
				case job := <-wp.JobQueue:
					err := job.Process()
					if err != nil {
						log.Printf("Worker %d: Job failed: %v\n", workerID, err)
					} else {
						// log.Printf("Worker %d: Job success\n", workerID)
					}
				case <-wp.Quit:
					log.Printf("Worker %d stopped\n", workerID)
					return
				}
			}
		}(i)
	}
}

// Stop waits for workers to finish
func (wp *WorkerPool) Stop() {
	close(wp.Quit)
	wp.wg.Wait()
}

// AddJob pushes a job to the queue (non-blocking if buffered)
func (wp *WorkerPool) AddJob(job Job) {
	wp.JobQueue <- job
}
