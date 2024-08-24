
const handler = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda Timely Invoked!'),
  };
};

export { handler };