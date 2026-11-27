/**
 * Prototype Edge Optimization utility for header compression and fast-path caching.
 */
export function optimizeEdgeHeaders(headers: Headers): Headers {
  const optimized = new Headers(headers)
  optimized.set('x-edge-optimized', 'true')
  optimized.set('cache-control', 'public, max-age=3600, s-maxage=86400')
  return optimized
}

export function shouldBypassCache(path: string): boolean {
  return path.startsWith('/api/v1/healthcheck') || path.startsWith('/api/v1/systemcheck')
}
