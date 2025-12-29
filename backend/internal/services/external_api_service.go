package services

import (
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"github.com/go-resty/resty/v2"
)

type ExternalAPIService struct {
	client *resty.Client
}

func NewExternalAPIService() *ExternalAPIService {
	return &ExternalAPIService{
		client: resty.New().SetTimeout(10 * time.Second),
	}
}

// CoinGecko Response Structures
type CoinGeckoSimplePrice map[string]struct {
	USD float64 `json:"usd"`
}

func (s *ExternalAPIService) GetCryptoPrices(ids []string) (map[string]float64, error) {
	// CoinGecko API (Free Tier)
	// Example: https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=usd
	
	url := fmt.Sprintf("https://api.coingecko.com/api/v3/simple/price?ids=%s&vs_currencies=usd", joinIDs(ids))
	
	var result CoinGeckoSimplePrice
	resp, err := s.client.R().SetResult(&result).Get(url)
	
	if err != nil {
		return nil, err
	}
	if resp.IsError() {
		return nil, errors.New("external API error: " + resp.Status())
	}

	prices := make(map[string]float64)
	for id, data := range result {
		prices[id] = data.USD
	}
	
	return prices, nil
}

// Helper to join IDs
func joinIDs(ids []string) string {
	res := ""
	for i, id := range ids {
		if i > 0 {
			res += ","
		}
		res += id
	}
	return res
}

// ExchangeRate-API (Free)
type ExchangeRateResponse struct {
	Result string             `json:"result"`
	Rates  map[string]float64 `json:"conversion_rates"`
}

func (s *ExternalAPIService) GetExchangeRates(baseCurrency string) (map[string]float64, error) {
	// Using a public free API for demo purposes
	url := fmt.Sprintf("https://v6.exchangerate-api.com/v6/YOUR_API_KEY/latest/%s", baseCurrency)
	// Note: Without a key, this particular call might fail or we fallback to a different open API.
	// For this demo, let's use a truly open one like frankfurter if possible, or simulate if key missing.
	
	// Fallback to Frankfurter (Open Source, No Key)
	url = fmt.Sprintf("https://api.frankfurter.app/latest?from=%s", baseCurrency)

	type FrankfurterResponse struct {
		Rates map[string]float64 `json:"rates"`
	}

	var result FrankfurterResponse
	resp, err := s.client.R().SetResult(&result).Get(url)

	if err != nil {
		return nil, err
	}
	
	return result.Rates, nil
}
