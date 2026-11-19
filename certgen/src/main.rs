use std::env;

fn is_prime(n: u64) -> bool {
    if n < 2 {
        return false;
    }
    if n == 2 {
        return true;
    }
    if n % 2 == 0 {
        return false;
    }
    let mut d = 3;
    while d <= n / d {
        if n % d == 0 {
            return false;
        }
        d += 2;
    }
    true
}

fn certificate(n: u64) -> Option<(u64, u64, u64)> {
    let primes: Vec<u64> = (2..=n).filter(|&p| is_prime(p)).collect();

    for (i, &p) in primes.iter().enumerate() {
        for &q in &primes[i..] {
            if p + q > n {
                break;
            }
            let r = n - p - q;
            if q <= r && primes.binary_search(&r).is_ok() {
                return Some((p, q, r));
            }
        }
    }
    None
}

fn main() {
    let upper = env::args()
        .nth(1)
        .and_then(|arg| arg.parse::<u64>().ok())
        .unwrap_or(31);

    if upper < 7 {
        eprintln!("upper bound must be at least 7");
        std::process::exit(2);
    }

    let mut n = 7;
    while n <= upper {
        let (p, q, r) = certificate(n)
            .unwrap_or_else(|| panic!("no three-prime certificate found for {n}"));
        println!("{{\"n\":{n},\"p\":{p},\"q\":{q},\"r\":{r}}}");
        n += 2;
    }
}
