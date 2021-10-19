using NUnit.Framework;
using Microsoft.Extensions.Logging;
using dotnet_actions_v_pipelines.Controllers;

namespace dotnet_actions_v_pipelines
{
    public class Tests
    {
        private ILogger<CalcController> _logger;

        [SetUp]
        public void Setup()
        {
            using var loggerFactory = LoggerFactory.Create(builder => builder.AddConsole());
            _logger = loggerFactory.CreateLogger<CalcController>();
        }

        [Test]
        public void TestAdd()
        {
            CalcController calc = new CalcController(_logger);

            Assert.That(calc.Add(2, 3), Is.EqualTo(5));
        }

        [Test]
        public void TestSubtract()
        {
            CalcController calc = new CalcController(_logger);

            Assert.That(calc.Subtract(2, 3), Is.EqualTo(-1));
        }

        [Test]
        public void TestMultiply()
        {
            CalcController calc = new CalcController(_logger);

            Assert.That(calc.Multiply(2, 3), Is.EqualTo(6));
        }
    }
}