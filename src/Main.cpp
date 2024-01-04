#include "quicksvg/graph_fn.hpp"
#include "quicksvg/plot_time_series.hpp"

#include <numbers>

static constexpr auto pi = std::numbers::pi;

void testing()
{
   std::vector<float> v(50);
   std::vector<float> u(50);
   float start_time = 0;
   float time_step = 0.25;
   for (size_t i = 0; i < v.size(); ++i) {
     v[i] = std::sin(start_time + i*time_step);
     u[i] = std::cos(start_time + i*time_step);
   }

   std::string title = "sine and cosine time series";
   std::string filename = "sin_cos_time_series_float.svg";

   quicksvg::plot_time_series pts(start_time, time_step, title, filename);
   pts.add_dataset(v);
   pts.add_dataset(u, false, "lime", "lightgreen");
   pts.write_all();
}

int main(int argc, char **argv) {
   testing();
   return 0;
}
